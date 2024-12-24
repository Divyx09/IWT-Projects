import initSqlJs from 'sql.js';
import { promises as fs } from 'fs';
import { DB_CONFIG } from '../config/database.js';

class DatabaseService {
  constructor() {
    this.db = null;
    this.initialized = false;
  }

  async initialize() {
    if (this.initialized) return;

    try {
      const SQL = await initSqlJs();
      let buffer;

      try {
        buffer = await fs.readFile(DB_CONFIG.filename);
      } catch {
        buffer = null;
      }

      this.db = new SQL.Database(buffer);
      
      // Create tables if they don't exist
      this.db.run(`
        CREATE TABLE IF NOT EXISTS todos (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          text TEXT NOT NULL,
          completed BOOLEAN DEFAULT 0
        )
      `);

      this.initialized = true;

      // Save database on process exit
      process.on('exit', () => {
        if (this.db) {
          const data = this.db.export();
          fs.writeFileSync(DB_CONFIG.filename, Buffer.from(data));
        }
      });

      // Handle process termination
      process.on('SIGINT', () => {
        this.cleanup();
        process.exit(0);
      });
    } catch (error) {
      console.error('Database initialization failed:', error);
      throw error;
    }
  }

  cleanup() {
    if (this.db) {
      const data = this.db.export();
      fs.writeFileSync(DB_CONFIG.filename, Buffer.from(data));
      this.db.close();
    }
  }

  getAllTodos() {
    const result = this.db.exec('SELECT * FROM todos');
    return result.length > 0 ? this.rowsToObjects(result[0]) : [];
  }

  addTodo(text) {
    this.db.run('INSERT INTO todos (text) VALUES (?)', [text]);
    const result = this.db.exec('SELECT * FROM todos WHERE id = last_insert_rowid()');
    return this.rowsToObjects(result[0])[0];
  }

  toggleTodo(id) {
    this.db.run(
      'UPDATE todos SET completed = CASE WHEN completed = 1 THEN 0 ELSE 1 END WHERE id = ?',
      [id]
    );
    const result = this.db.exec('SELECT * FROM todos WHERE id = ?', [id]);
    return this.rowsToObjects(result[0])[0];
  }

  deleteTodo(id) {
    this.db.run('DELETE FROM todos WHERE id = ?', [id]);
  }

  rowsToObjects(result) {
    const { columns, values } = result;
    return values.map(row => 
      Object.fromEntries(columns.map((col, i) => [col, row[i]]))
    );
  }
}

export const dbService = new DatabaseService();
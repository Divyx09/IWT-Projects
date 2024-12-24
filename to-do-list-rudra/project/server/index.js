import express from 'express';
import cors from 'cors';
import { initializeDatabase } from './db.js';
import todoRoutes from './routes/todoRoutes.js';
import { DB_CONFIG } from './config/database.js';

const app = express();

app.use(cors());
app.use(express.json());
app.use(DB_CONFIG.apiPrefix, todoRoutes);

// Initialize database before starting server
initializeDatabase().then(() => {
  app.listen(DB_CONFIG.port, () => {
    console.log(`Server running on port ${DB_CONFIG.port}`);
  });
}).catch(error => {
  console.error('Failed to initialize database:', error);
  process.exit(1);
});
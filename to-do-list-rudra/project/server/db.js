import { dbService } from './services/dbService.js';

export async function initializeDatabase() {
  await dbService.initialize();
}

export function getAllTodos() {
  return dbService.getAllTodos();
}

export function addTodo(text) {
  return dbService.addTodo(text);
}

export function toggleTodo(id) {
  return dbService.toggleTodo(id);
}

export function deleteTodo(id) {
  return dbService.deleteTodo(id);
}
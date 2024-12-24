import express from 'express';
import { getAllTodos, addTodo, toggleTodo, deleteTodo } from '../db.js';

const router = express.Router();

router.get('/todos', (req, res) => {
  try {
    const todos = getAllTodos();
    res.json(todos);
  } catch (error) {
    console.error('Error getting todos:', error);
    res.status(500).json({ error: 'Failed to get todos' });
  }
});

router.post('/todos', (req, res) => {
  try {
    const { text } = req.body;
    if (!text?.trim()) {
      return res.status(400).json({ error: 'Todo text is required' });
    }
    const todo = addTodo(text);
    res.json(todo);
  } catch (error) {
    console.error('Error adding todo:', error);
    res.status(500).json({ error: 'Failed to add todo' });
  }
});

router.put('/todos/:id', (req, res) => {
  try {
    const { id } = req.params;
    const todo = toggleTodo(id);
    if (!todo) {
      return res.status(404).json({ error: 'Todo not found' });
    }
    res.json(todo);
  } catch (error) {
    console.error('Error updating todo:', error);
    res.status(500).json({ error: 'Failed to update todo' });
  }
});

router.delete('/todos/:id', (req, res) => {
  try {
    const { id } = req.params;
    deleteTodo(id);
    res.json({ message: 'Todo deleted' });
  } catch (error) {
    console.error('Error deleting todo:', error);
    res.status(500).json({ error: 'Failed to delete todo' });
  }
});

export default router;
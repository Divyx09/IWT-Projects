import { useState, useCallback } from 'react';
import { useAsync } from './useAsync';
import api from '../services/api';

export function useTodos() {
  const [todos, setTodos] = useState([]);
  
  const { execute: executeFetch, loading: fetchLoading, error: fetchError } = 
    useAsync(api.getTodos);
  
  const { execute: executeAdd, loading: addLoading, error: addError } = 
    useAsync(api.addTodo);
  
  const { execute: executeToggle, loading: toggleLoading, error: toggleError } = 
    useAsync(api.toggleTodo);
  
  const { execute: executeDelete, loading: deleteLoading, error: deleteError } = 
    useAsync(api.deleteTodo);

  const fetchTodos = useCallback(async () => {
    const data = await executeFetch();
    setTodos(data || []);
  }, [executeFetch]);

  const addTodo = useCallback(async (text) => {
    const newTodo = await executeAdd(text);
    setTodos(prev => [...prev, newTodo]);
  }, [executeAdd]);

  const toggleTodo = useCallback(async (id) => {
    const updatedTodo = await executeToggle(id);
    setTodos(prev => prev.map(todo => 
      todo.id === id ? updatedTodo : todo
    ));
  }, [executeToggle]);

  const deleteTodo = useCallback(async (id) => {
    await executeDelete(id);
    setTodos(prev => prev.filter(todo => todo.id !== id));
  }, [executeDelete]);

  const error = fetchError || addError || toggleError || deleteError;
  const loading = fetchLoading || addLoading || toggleLoading || deleteLoading;

  return {
    todos,
    error,
    loading,
    fetchTodos,
    addTodo,
    toggleTodo,
    deleteTodo
  };
}
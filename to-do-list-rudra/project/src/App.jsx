import { useEffect } from 'react';
import TodoForm from './components/TodoForm';
import TodoList from './components/TodoList';
import ErrorMessage from './components/ErrorMessage';
import LoadingSpinner from './components/LoadingSpinner';
import { useTodos } from './hooks/useTodos';
import './App.css';

function App() {
  const { 
    todos, 
    error, 
    loading, 
    fetchTodos, 
    addTodo, 
    toggleTodo, 
    deleteTodo 
  } = useTodos();

  useEffect(() => {
    fetchTodos().catch(() => {
      // Error is handled by useTodos hook
    });
  }, [fetchTodos]);

  return (
    <div className="todo-app">
      <h1>Todo App</h1>
      <ErrorMessage message={error} />
      {loading && <LoadingSpinner />}
      <TodoForm onAdd={addTodo} />
      <TodoList 
        todos={todos}
        onToggle={toggleTodo}
        onDelete={deleteTodo}
      />
    </div>
  );
}

export default App;
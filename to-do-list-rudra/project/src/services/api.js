import axios from 'axios';

const API_URL = 'http://localhost:3000/api';

const api = {
  async getTodos() {
    const response = await axios.get(`${API_URL}/todos`);
    return response.data;
  },

  async addTodo(text) {
    const response = await axios.post(`${API_URL}/todos`, { text });
    return response.data;
  },

  async toggleTodo(id) {
    const response = await axios.put(`${API_URL}/todos/${id}`);
    return response.data;
  },

  async deleteTodo(id) {
    await axios.delete(`${API_URL}/todos/${id}`);
  }
};

export default api;
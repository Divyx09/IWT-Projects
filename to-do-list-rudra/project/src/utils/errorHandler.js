// Centralized error handling utility
export function handleApiError(error, defaultMessage) {
  if (error.response) {
    // Server responded with error status
    return error.response.data.error || defaultMessage;
  } else if (error.request) {
    // Request made but no response
    return 'Network error. Please check your connection.';
  }
  // Other errors
  return defaultMessage;
}
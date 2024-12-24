import { useState, useCallback } from 'react';
import { handleApiError } from '../utils/errorHandler';

export function useAsync(asyncFn) {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const execute = useCallback(async (...args) => {
    try {
      setLoading(true);
      setError(null);
      const result = await asyncFn(...args);
      return result;
    } catch (err) {
      const errorMessage = handleApiError(err, 'An error occurred');
      setError(errorMessage);
      throw err;
    } finally {
      setLoading(false);
    }
  }, [asyncFn]);

  return { execute, loading, error };
}
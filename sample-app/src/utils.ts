/**
 * Utility Functions
 * Test Case 3: New Function Addition
 */

export function getTestMetric(name: string): number {
  const timestamp = Date.now();
  const hash = name.split('').reduce((acc, char) => {
    return acc + char.charCodeAt(0);
  }, 0);
  return (timestamp + hash) % 1000;
}

export function calculateScore(metrics: number[]): number {
  return metrics.reduce((sum, val) => sum + val, 0) / metrics.length;
}

export function formatBytes(bytes: number): string {
  if (bytes === 0) return '0 Bytes';
  const k = 1024;
  const sizes = ['Bytes', 'KB', 'MB', 'GB'];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return Math.round(bytes / Math.pow(k, i) * 100) / 100 + ' ' + sizes[i];
}

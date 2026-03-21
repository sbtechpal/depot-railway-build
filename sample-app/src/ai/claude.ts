/**
 * Claude AI Integration
 */

import type { AIModel } from '../types.js';

export class ClaudeModel implements AIModel {
  name = 'claude' as const;
  private apiKey: string;

  constructor(apiKey: string) {
    this.apiKey = apiKey;
  }

  async processMessage(message: string): Promise<string> {
    // Simulated Claude API call
    await new Promise(resolve => setTimeout(resolve, 500));

    // Demo response
    return `[Claude] I received your message: "${message.substring(0, 100)}"`;
  }
}

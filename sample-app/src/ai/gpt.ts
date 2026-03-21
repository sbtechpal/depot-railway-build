/**
 * GPT-4 AI Integration
 */

import type { AIModel } from '../types.js';

export class GPTModel implements AIModel {
  name = 'gpt-4' as const;
  private apiKey: string;

  constructor(apiKey: string) {
    this.apiKey = apiKey;
  }

  async processMessage(message: string): Promise<string> {
    // Simulated GPT API call
    await new Promise(resolve => setTimeout(resolve, 500));

    // Demo response
    return `[GPT-4] I received your message: "${message.substring(0, 100)}"`;
  }
}

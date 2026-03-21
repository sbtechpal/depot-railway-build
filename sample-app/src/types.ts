/**
 * OpenClaw Demo - Personal AI Assistant
 * Type definitions for the skills system
 */

export interface Skill {
  name: string;
  description: string;
  execute: (context: SkillContext) => Promise<SkillResult>;
}

export interface SkillContext {
  input: string;
  userId: string;
  timestamp: Date;
  metadata?: Record<string, unknown>;
}

export interface SkillResult {
  success: boolean;
  output: string;
  metadata?: Record<string, unknown>;
}

export interface Message {
  platform: 'telegram' | 'whatsapp' | 'discord' | 'api';
  content: string;
  userId: string;
  timestamp: Date;
}

export interface AIModel {
  name: 'claude' | 'gpt-4' | 'local';
  processMessage(message: string): Promise<string>;
}

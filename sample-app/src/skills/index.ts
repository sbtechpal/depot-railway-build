/**
 * OpenClaw Skills System
 * Extensible skills framework for AI agent capabilities
 */

import type { Skill, SkillContext, SkillResult } from '../types.js';

export class SkillRegistry {
  private skills: Map<string, Skill> = new Map();

  register(skill: Skill): void {
    this.skills.set(skill.name, skill);
    console.log(`[Skill] Registered: ${skill.name}`);
  }

  get(name: string): Skill | undefined {
    return this.skills.get(name);
  }

  list(): Skill[] {
    return Array.from(this.skills.values());
  }

  async execute(name: string, context: SkillContext): Promise<SkillResult> {
    const skill = this.get(name);
    if (!skill) {
      return {
        success: false,
        output: `Skill not found: ${name}`,
      };
    }
    return await skill.execute(context);
  }
}

// Built-in skills
export const emailSkill: Skill = {
  name: 'email',
  description: 'Send and manage emails',
  execute: async (context: SkillContext): Promise<SkillResult> => {
    // Simulated email processing
    await new Promise(resolve => setTimeout(resolve, 100));
    return {
      success: true,
      output: `Email processed: ${context.input.substring(0, 50)}...`,
      metadata: { processed: true },
    };
  },
};

export const calendarSkill: Skill = {
  name: 'calendar',
  description: 'Manage calendar events and reminders',
  execute: async (context: SkillContext): Promise<SkillResult> => {
    await new Promise(resolve => setTimeout(resolve, 100));
    return {
      success: true,
      output: `Calendar updated: ${context.input.substring(0, 50)}...`,
      metadata: { action: 'calendar_update' },
    };
  },
};

export const reminderSkill: Skill = {
  name: 'reminder',
  description: 'Set and manage reminders',
  execute: async (context: SkillContext): Promise<SkillResult> => {
    await new Promise(resolve => setTimeout(resolve, 100));
    return {
      success: true,
      output: `Reminder set: ${context.input.substring(0, 50)}...`,
      metadata: { reminderSet: true },
    };
  },
};

export const webSearchSkill: Skill = {
  name: 'web-search',
  description: 'Search the web for information',
  execute: async (context: SkillContext): Promise<SkillResult> => {
    await new Promise(resolve => setTimeout(resolve, 200));
    return {
      success: true,
      output: `Found results for: ${context.input.substring(0, 30)}...`,
      metadata: { resultsCount: 5 },
    };
  },
};

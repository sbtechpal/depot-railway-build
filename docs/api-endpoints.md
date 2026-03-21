# OpenClaw Demo API Reference

The demo application exposes a REST API for testing and integration.

## Base URL

```
http://localhost:3000
```

Or when deployed:
```
https://your-app.railway.app
```

## Endpoints

### GET /health

Health check endpoint.

**Response**
```json
{
  "status": "healthy",
  "service": "OpenClaw Demo",
  "version": "1.0.0",
  "skills": 4
}
```

**Status Codes**
- `200 OK` - Service is healthy

---

### GET /skills

List all available skills.

**Response**
```json
{
  "skills": [
    {
      "name": "email",
      "description": "Send and manage emails"
    },
    {
      "name": "calendar",
      "description": "Manage calendar events and reminders"
    },
    {
      "name": "reminder",
      "description": "Set and manage reminders"
    },
    {
      "name": "web-search",
      "description": "Search the web for information"
    }
  ]
}
```

**Status Codes**
- `200 OK` - Skills list returned

---

### POST /message

Process a message with AI and optionally execute a skill.

**Request Body**
```json
{
  "platform": "api",
  "content": "Send an email to john@example.com",
  "userId": "user-123",
  "timestamp": "2025-03-21T10:00:00Z",
  "skill": "email"
}
```

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `platform` | string | Yes | Message platform (`telegram`, `whatsapp`, `discord`, `api`) |
| `content` | string | Yes | The message content |
| `userId` | string | Yes | User identifier |
| `timestamp` | string | No | ISO 8601 timestamp |
| `skill` | string | No | Skill to execute |

**Response**
```json
{
  "success": true,
  "aiResponse": "[Claude] I received your message: \"Send an email to john@example.com\"",
  "skillResult": {
    "success": true,
    "output": "Email processed: Send an email to john@example.com",
    "metadata": {
      "processed": true
    }
  },
  "timestamp": "2025-03-21T10:00:01.234Z"
}
```

**Status Codes**
- `200 OK` - Message processed successfully
- `400 Bad Request` - Invalid request body
- `500 Internal Server Error` - Server error

## Example Usage

### cURL

```bash
# Health check
curl http://localhost:3000/health

# List skills
curl http://localhost:3000/skills

# Send a message
curl -X POST http://localhost:3000/message \
  -H "Content-Type: application/json" \
  -d '{
    "platform": "api",
    "content": "Set a reminder for tomorrow at 2pm",
    "userId": "user-123",
    "skill": "reminder"
  }'
```

### JavaScript (fetch)

```javascript
// Health check
const health = await fetch('http://localhost:3000/health')
  .then(r => r.json());
console.log(health);

// Send a message
const response = await fetch('http://localhost:3000/message', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    platform: 'api',
    content: 'What is the weather today?',
    userId: 'user-123',
    skill: 'web-search'
  })
});
const data = await response.json();
console.log(data);
```

### Python (requests)

```python
import requests

# Health check
health = requests.get('http://localhost:3000/health').json()
print(health)

# Send a message
response = requests.post('http://localhost:3000/message', json={
    'platform': 'api',
    'content': 'Add meeting to my calendar',
    'userId': 'user-123',
    'skill': 'calendar'
})
print(response.json())
```

## Error Handling

### Error Response Format

```json
{
  "success": false,
  "error": "Error message describing what went wrong"
}
```

### Common Errors

| Status | Error | Cause | Solution |
|--------|-------|-------|----------|
| 400 | Invalid request body | Missing required fields | Check request format |
| 500 | Skill not found | Invalid skill name | Use valid skill name |
| 500 | Unknown error | Server-side issue | Check logs |

## Rate Limiting

The demo API has no rate limiting by default. When deploying to production, consider:
- Implementing rate limiting per user
- Adding authentication
- Logging all requests for audit

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `PORT` | `3000` | Server port |
| `NODE_ENV` | `development` | Environment (development/production) |
| `ANTHROPIC_API_KEY` | `demo-key` | Claude API key |
| `OPENAI_API_KEY` | - | OpenAI API key (optional) |

## Docker Usage

```bash
# Build the image
docker build -t openclaw-demo .

# Run the container
docker run -p 3000:3000 \
  -e ANTHROPIC_API_KEY=your_key_here \
  openclaw-demo

# Test the API
curl http://localhost:3000/health
```

---

For more information, see the [main README](../README.md).

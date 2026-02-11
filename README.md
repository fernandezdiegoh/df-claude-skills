# df-claude-skills

Skills personalizadas para Claude Code. Optimizadas para detectar patrones de codigo generado por LLMs.

## Skills disponibles

| Skill | Descripcion | Version |
|-------|-------------|---------|
| `pr-review` | Review riguroso de PRs, asume que hay problemas hasta demostrar lo contrario | 2.0.0 |
| `codebase-audit` | Auditoria completa — arquitectura, seguridad, deuda tecnica, roadmap de remediacion | 2.0.0 |
| `documentation-expert` | Creacion y mantenimiento de documentacion tecnica | 1.0.0 |
| `frontend-design` | Interfaces frontend distintivas y production-grade | 1.0.0 |

## Instalacion

Copiar las skills a tu proyecto:

```bash
cp -r skills/<skill-name> <tu-proyecto>/.claude/skills/
```

O para instalarlas todas:

```bash
cp -r skills/* <tu-proyecto>/.claude/skills/
```

## Uso

Desde Claude Code, invocar con `/skill-name`. Por ejemplo:

- `/pr-review` — review de un PR
- `/codebase-audit` — auditoria completa del codebase

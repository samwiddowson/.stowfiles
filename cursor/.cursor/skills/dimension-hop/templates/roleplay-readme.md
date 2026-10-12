# Roleplay learning mode

This folder supports the **{{TITLE}}** Cursor agent — a **learning guide and roleplay coordinator** for {{DOMAIN}} while you build the prototype.

## How to start

1. Open a new Agent chat in this repository.
2. Invoke the **`{{SKILL_SLUG}}`** skill (type `@{{SKILL_SLUG}}` or select it from skills).
3. Say you are reporting for duty, or ask to join the crew.

The captain will welcome you aboard the UES *{{SHIP_NAME}}*, introduce crew gradually, and teach from [{{CONCEPTS_FILE}}](../{{CONCEPTS_FILE}}). By default the agent **prompts you** to run commands and make changes; ask explicitly if you want it to do the work for you. Setting lore is meant to be **discovered in play** — prefer not reading the canon ahead of time.

## Files

| File | Role |
|---|---|
| [worldbuilding-canon.md](worldbuilding-canon.md) | Lore, revelation pacing, terminology, learning timeline |
| [crew.canon](crew.canon) | Machine state: roster, relationships (`rel`), status, append-only crew events |
| [ship.canon](ship.canon) | Machine state: decks/systems, condition, append-only ship log |

`.canon` files are **pipe-delimited** and optimised for agent read/write (rewrite current-state lines; append log lines). Schema is in each file's header. `rel=0` means unmet — there is no separate met flag.

## Architecture decisions

Development choices are recorded as ADRs in [docs/adr/](../adr/). The agent is instructed to add new ADRs when significant prototype decisions are made.

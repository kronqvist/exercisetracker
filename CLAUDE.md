# Exercise Tracker

## Project Overview

A single-file PWA exercise tracker (`index.html`) using browser localStorage. No backend. Designed for daily tracking of rehabilitation and strength exercises.

## User's Clinical Condition

The user has a documented lumbar-pelvic condition requiring ongoing rehabilitation:

- **Structural leg length discrepancy (LLD):** 12 mm (right longer than left), causing compensatory lateral pelvic tilt and functional lumbar scoliosis
- **Lumbar spine:** Progressive degenerative disc changes at L3-L4, L4-L5, and L5-S1, including a medial annular fissure at L4-L5 and symmetric disc bulge at L5-S1
- **Left SI joint:** Chronic sacroiliitis with mechanical irritation, positive impingement sign, restricted internal rotation of left hip
- **Muscular pattern:** Hypertonicity in left TFL, iliopsoas, gluteus medius, and deep hip rotators. Over-reliance on rectus femoris for hip flexion. Reduced hip adduction strength due to active inflammation

### Prescribed Rehabilitation Objectives

1. **Inhibition:** Myofascial release of deep hip rotators and gluteus medius to reduce neural irritation
2. **Stabilization:** Transversus abdominis activation ("tuck under" maneuvers) to eliminate lumbar hyper-lordosis during movement
3. **Integration:** Bilateral hip loading (hip thrusts) with abduction and adduction to stabilize pelvic girdle, banded reciprocal drills for motor control

## Overall Goal

Overcome the biomechanical issues described above and become overall stronger. All features should be designed to support consistency, progressive loading, and balanced rehabilitation coverage.

## Critical Rules

- **No changes are allowed that would overwrite existing user data.** All data in localStorage is irreplaceable. Any feature that writes to localStorage must preserve existing entries. Import/merge operations must confirm with the user before touching any key that already has a value.
- **Every change must bump the version number** in `service-worker.js` (`APP_VERSION` constant). This ensures the PWA cache is invalidated and users get the latest version.
- **Summary format:** When done with a change, format the summary like a git commit — a short title line (imperative mood, under 70 chars) followed by a body describing what changed and why.

## Technical Notes

- Entire app lives in `index.html` (HTML + CSS + JS, no build step)
- Data stored in localStorage with keys: `ex:{exerciseId}:{YYYY-MM-DD}:count` and `ex:{exerciseId}:{YYYY-MM-DD}:notes`
- PWA with service worker for offline support
- Dark theme, mobile-first design

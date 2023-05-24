import { registerPlugin } from '@jigra/core';

import type { ScreenOrientationPlugin } from './definitions';

const ScreenOrientation = registerPlugin<ScreenOrientationPlugin>('ScreenOrientation', {
  web: () => import('./web').then((m) => new m.ScreenOrientationWeb()),
});

export * from './definitions';
export { ScreenOrientation };

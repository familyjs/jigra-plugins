import { registerPlugin } from '@jigra/core';

import type { BrowserPlugin } from './definitions';

const Browser = registerPlugin<BrowserPlugin>('Browser', {
  web: () => import('./web').then((m) => new m.BrowserWeb()),
});

export * from './definitions';
export { Browser };

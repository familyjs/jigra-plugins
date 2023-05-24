import { registerPlugin } from '@jigra/core';

import type { ActionSheetPlugin } from './definitions';

const ActionSheet = registerPlugin<ActionSheetPlugin>('ActionSheet', {
  web: () => import('./web').then((m) => new m.ActionSheetWeb()),
});

export * from './definitions';
export { ActionSheet };

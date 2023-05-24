import { registerPlugin } from '@jigra/core';

import type { PushNotificationsPlugin } from './definitions';

const PushNotifications = registerPlugin<PushNotificationsPlugin>('PushNotifications', {});

export * from './definitions';
export { PushNotifications };

import { PROJECTS } from './lib/jigra.mjs';
import { execute } from './lib/cli.mjs';
import { bootstrap } from './lib/lerna.mjs';
import {
  getLatestVersion,
  setLernaPackageDependencies,
} from './lib/version.mjs';

execute(async () => {
  const packages = Object.fromEntries(
    await Promise.all(
      PROJECTS.map(async project => [
        `@jigra/${project}`,
        `^${await getLatestVersion(`@jigra/${project}`, 'latest')}`,
      ]),
    ),
  );

  await setLernaPackageDependencies(packages, 'devDependencies');
  await setLernaPackageDependencies(packages, 'peerDependencies');
  await bootstrap();
});

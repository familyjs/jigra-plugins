import { PROJECTS, PEERPROJECTS } from './lib/jigra.mjs';
import { execute } from './lib/cli.mjs';
import { setLernaPackageDependencies } from './lib/version.mjs';
import { bootstrap } from './lib/lerna.mjs';

execute(async () => {
  const packages = Object.fromEntries(
    PROJECTS.map(project => [`@jigra/${project}`, process.argv[2]]),
  );
  const peerPackages = Object.fromEntries(
    PEERPROJECTS.map(project => [`@jigra/${project}`, process.argv[2]]),
  );

  await setLernaPackageDependencies(packages, 'devDependencies');
  await setLernaPackageDependencies(peerPackages, 'peerDependencies');
  await bootstrap();
});

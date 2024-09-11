import { PROJECTS, PEERPROJECTS } from './lib/jigra.mjs';
import { execute } from './lib/cli.mjs';
import { root } from './lib/repo.mjs';
import { run } from './lib/subprocess.mjs';
import { setLernaPackageDependencies } from './lib/version.mjs';

execute(async () => {
  const packages = Object.fromEntries(PROJECTS.map((project) => [`@jigra/${project}`, process.argv[2]]));
  const peerPackages = Object.fromEntries(PEERPROJECTS.map((project) => [`@jigra/${project}`, process.argv[2]]));

  await setLernaPackageDependencies(packages, 'devDependencies');
  await setLernaPackageDependencies(peerPackages, 'peerDependencies');
  await run('npm', ['install'], { cwd: root, stdio: 'inherit' });
});

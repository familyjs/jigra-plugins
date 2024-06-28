const { relative, resolve } = require('path');
const core = require('@actions/core')

async function main() {
  const {root} = await import('../../../scripts/lib/repo.mjs');
  const {execute} = await import('../../../scripts/lib/cli.mjs');
  const {ls} = await import('../../../scripts/lib/lerna.mjs');

  execute(async () => {
    let filesInput = core.getInput('files', '[]');
    let files;

    try {
      files = filesInput ? JSON.parse(filesInput) : [];
    } catch (error) {
      core.setFailed(`Invalid JSON input for 'files': ${error.message}`);
      return;
    }

    if (!Array.isArray(files)) {
      core.setFailed("The 'files' input is not an array.");
      return;
    }

    const resolvedFiles = files.map(f => resolve(root, f));
    const packages = await ls();
    const changedPackages = packages.filter(pkg => resolvedFiles.some(f => f.startsWith(pkg.location)));
    const paths = JSON.stringify(changedPackages.map(pkg => relative(root, pkg.location)));

    core.info(`Changed package paths: ${paths}`);
    core.setOutput('paths', paths);
  });
}

main().catch(error => {
  core.setFailed(error.message);
});

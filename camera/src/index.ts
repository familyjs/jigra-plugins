import { registerPlugin } from "@jigra/core";

import type { CameraPlugin } from "./definitions";
import { CameraWeb } from "./web";

const Camera = registerPlugin<CameraPlugin>("Camera", {
  web: () => new CameraWeb(),
});

export * from "./definitions";
export { Camera };

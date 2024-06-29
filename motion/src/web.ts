import { WebPlugin } from "@jigra/core";

import type { MotionPlugin } from "./definitions";

export class MotionWeb extends WebPlugin implements MotionPlugin {
  constructor() {
    super();
    this.registerWindowListener("devicemotion", "accel");
    this.registerWindowListener("deviceorientation", "orientation");
  }
}

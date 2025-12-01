const rl = @import("raylib");
const std = @import("std");
const Player = struct { x: i32, y: i32, w: i32, h: i32, speed: i32, vx: i32, vy: i32, color: rl.Color };

pub fn main() anyerror!void {
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "mpp");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    var p1: Player = .{ .x = 0, .y = 0, .w = 40, .h = 40, .vx = 0, .vy = 0, .color = rl.Color.red, .speed = 250 };
    while (!rl.windowShouldClose()) {
        if (rl.isKeyDown(rl.KeyboardKey.w)) {
            p1.vy = -1 * p1.speed;
        } else if (rl.isKeyDown(rl.KeyboardKey.s)) {
            p1.vy = p1.speed;
        } else {
            p1.vy = 0;
        }
        if (rl.isKeyDown(rl.KeyboardKey.a)) {
            p1.vx = -1 * p1.speed;
        } else if (rl.isKeyDown(rl.KeyboardKey.d)) {
            p1.vx = p1.speed;
        } else {
            p1.vx = 0;
        }

        p1.x = @intFromFloat(@as(f32, @floatFromInt(p1.vx)) * rl.getFrameTime() + @as(f32, @floatFromInt(p1.x)));
        p1.y = @intFromFloat(@as(f32, @floatFromInt(p1.vy)) * rl.getFrameTime() + @as(f32, @floatFromInt(p1.y)));

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.white);

        rl.drawRectangle(p1.x, p1.y, p1.w, p1.h, p1.color);
        rl.drawText("Congrats! You created your first window!", 190, 200, 20, .light_gray);
    }
}

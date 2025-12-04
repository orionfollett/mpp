const rl = @import("raylib");
const std = @import("std");
const Card = struct { rect: rl.Rectangle, color: rl.Color };

pub fn main() anyerror!void {
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "mpp");
    defer rl.closeWindow();

    rl.setTargetFPS(60);

    var c: Card = .{ .rect = .{ .x = 0, .y = 0, .width = 40, .height = 40 }, .color = rl.Color.red };

    while (!rl.windowShouldClose()) {
        if (rl.isKeyDown(rl.KeyboardKey.w)) {
            std.debug.print("W\n", .{});
        }
        HandleMouse(&c);
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.white);

        rl.drawRectangleRec(c.rect, c.color);
        rl.drawText("Congrats! You created your first window!", 190, 200, 20, .light_gray);
    }
}

pub fn HandleMouse(c: *Card) void {
    if (rl.isMouseButtonDown(rl.MouseButton.left)) {
        const v = rl.getMousePosition();
        if (rl.checkCollisionPointRec(v, c.rect)) {
            c.rect.x = v.x;
            c.rect.y = v.y;
        }
    }
}

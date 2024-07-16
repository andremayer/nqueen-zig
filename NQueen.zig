const std = @import("std");

fn isValidMove(proposedRow: usize, proposedCol: usize, solution: []const usize) bool {
    for (0..proposedRow) |i| {
        const oldCol = solution[i];
        const diagonalOffset = proposedRow - i;

        if ((oldCol == proposedCol) or
            (proposedCol >= diagonalOffset and oldCol == proposedCol - diagonalOffset) or
            (proposedCol + diagonalOffset < solution.len and oldCol == proposedCol + diagonalOffset))
        {
            return false;
        }
    }
    return true;
}

fn drawBoard(solution: []const usize) void {
    const size = solution.len;
    for (0..size) |row| {
        for (0..size) |col| {
            if (solution[row] == col) {
                std.debug.print("Q ", .{});
            } else {
                std.debug.print(". ", .{});
            }
        }
        std.debug.print("\n", .{});
    }
    std.debug.print("\n", .{});
}

fn solveNQueens(n: usize) usize {
    var results: usize = 0;
    var solution: [8]usize = undefined;
    var solStack: [8]usize = undefined;
    var stackSize: usize = 0;

    var row: usize = 0;
    var col: usize = 0;

    while (row < n) {
        while (col < n) {
            if (isValidMove(row, col, solution[0..row])) {
                solStack[stackSize] = col;
                stackSize += 1;
                solution[row] = col;
                row += 1;
                col = 0;
                break;
            }
            col += 1;
        }

        if (col == n) {
            if (stackSize != 0) {
                stackSize -= 1;
                col = solStack[stackSize] + 1;
                row -= 1;
            } else {
                break;
            }
        }

        if (row == n) {
            results += 1;
            drawBoard(solution[0..n]);
            row -= 1;
            stackSize -= 1;
            col = solStack[stackSize] + 1;
        }
    }
    return results;
}

pub fn main() void {
    const n_values = [_]usize{4};

    for (n_values) |n| {
        const res = solveNQueens(n);
        std.debug.print("Total solutions count for {} queens on the chessboard ({}x{}): {}\n", .{ n, n, n, res });
    }
}

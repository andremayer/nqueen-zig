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

fn solveNQueens(n: usize, row: usize, solution: []usize, results: *usize) void {
    if (row == n) {
        results.* += 1;
        drawBoard(solution);
        return;
    }

    for (0..n) |col| {
        if (isValidMove(row, col, solution)) {
            solution[row] = col;
            solveNQueens(n, row + 1, solution, results);
        }
    }
}

pub fn main() void {
    const n_values = [_]usize{4};

    for (n_values) |n| {
        var results: usize = 0;
        var solution: [8]usize = undefined;
        solveNQueens(n, 0, solution[0..n], &results);
        std.debug.print("Found {} solution(s)! :) \n", .{results});
    }
}

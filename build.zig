const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const freetype = b.addLibrary(.{
        .name = "freetype",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .sanitize_c = .off,
        }),
    });
    freetype.root_module.addCMacro("FT2_BUILD_LIBRARY", "1");
    freetype.root_module.addCSourceFiles(.{
        .root = b.path("src"),
        .files = &.{
            "autofit/autofit.c",
            "base/ftbase.c",
            "base/ftsystem.c",
            "base/ftdebug.c",
            "base/ftbbox.c",
            "base/ftbdf.c",
            "base/ftbitmap.c",
            "base/ftcid.c",
            "base/ftfstype.c",
            "base/ftgasp.c",
            "base/ftglyph.c",
            "base/ftgxval.c",
            "base/ftinit.c",
            "base/ftmm.c",
            "base/ftotval.c",
            "base/ftpatent.c",
            "base/ftpfr.c",
            "base/ftstroke.c",
            "base/ftsynth.c",
            "base/fttype1.c",
            "base/ftwinfnt.c",
            "bdf/bdf.c",
            "bzip2/ftbzip2.c",
            "cache/ftcache.c",
            "cff/cff.c",
            "cid/type1cid.c",
            "gzip/ftgzip.c",
            "lzw/ftlzw.c",
            "pcf/pcf.c",
            "pfr/pfr.c",
            "psaux/psaux.c",
            "pshinter/pshinter.c",
            "psnames/psnames.c",
            "raster/raster.c",
            "sdf/sdf.c",
            "sfnt/sfnt.c",
            "smooth/smooth.c",
            "svg/svg.c",
            "truetype/truetype.c",
            "type1/type1.c",
            "type42/type42.c",
            "winfonts/winfnt.c",
        },
        .language = .c,
        .flags = &.{
            "-std=c99",
            "-fno-sanitize=undefined",
        },
    });
    freetype.addIncludePath(b.path("include/"));
    freetype.installHeadersDirectory(b.path("include/"), "", .{});
    b.installArtifact(freetype);
    switch (target.result.os.tag) {
        .emscripten => freetype.addIncludePath(.{
            .cwd_relative = b.pathJoin(&.{ b.sysroot orelse @panic("emscripten sysroot not set"), "/include" }),
        }),
        .macos => {
            freetype.root_module.addCSourceFile(.{
                .file = b.path("src/base/ftmac.c"),
                .language = .c,
                .flags = &.{
                    "-std=c99",
                    "-fno-sanitize=undefined",
                },
            });
        },
        else => freetype.root_module.link_libc = true,
    }

    const zfreetype = b.addModule("zfreetype", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    zfreetype.linkLibrary(freetype);

    const test_step = b.step("test", "Run freetype tests");
    const tests = b.addTest(.{
        .name = "freetype-tests",
        .root_source_file = b.path("src/freetype.zig"),
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(tests);
    test_step.dependOn(&b.addRunArtifact(tests).step);
}

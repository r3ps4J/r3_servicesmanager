import fs from "fs";
import gaze from "gaze";
import { bundle } from "luabundle";
import path from "path";

fs.writeFileSync(
    ".yarn.installed",
    new Date().toLocaleString("en-NL", {
        timeZone: "UTC",
        timeStyle: "long",
        dateStyle: "full",
    })
);

function bundleFiles() {
    try {
        const content = bundle(`./src/main.lua`, {
            paths: ["./src/?.lua"],
            luaVersion: "LuaGLM",
        });

        const output = "./dist/main.lua";
        const resolvedPath = path.resolve(output);
        const resolvedDir = path.dirname(resolvedPath);

        if (!fs.existsSync(resolvedDir)) {
            fs.mkdirSync(resolvedDir, { recursive: true });
        }

        fs.writeFileSync(output, content);

        console.log(`Bundled lua files to '${output}'`);
    } catch (error) {
        console.error(`Error while bundling lua files:\n${error.stack}`);
    }
}

bundleFiles();

if (process.argv.includes("--watch")) {
    const targetPath = "./src/**/*.lua";
    console.log(`\nWatching file changes at '${targetPath}'\n`);

    gaze(targetPath, function () {
        this.on("all", function (event, filepath) {
            const relativePath = path.relative("./", filepath);
            console.log(`'${relativePath}' was ${event}, rebundling files...`);
            bundleFiles();
            console.log();
        });
    });
}

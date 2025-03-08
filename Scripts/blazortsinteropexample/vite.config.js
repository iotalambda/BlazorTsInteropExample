import { defineConfig } from "vite"

// https://vitejs.dev/config/
export default defineConfig({
    build: {
        emptyOutDir: true,
        outDir: "../../wwwroot/js/dist",
        lib: {
            entry: [
                "src/browserConsoleAdapter.ts",
                "src/pointerEventsAdapter.ts",
            ],
            formats: ["es"],
        },
    },
})

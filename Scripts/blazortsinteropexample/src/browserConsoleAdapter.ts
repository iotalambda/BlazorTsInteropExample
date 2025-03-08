import { IBrowserConsoleAdapter } from "./typings"

async function logAsync(message: string) {
    console.log(message)
}

export default { logAsync } as IBrowserConsoleAdapter

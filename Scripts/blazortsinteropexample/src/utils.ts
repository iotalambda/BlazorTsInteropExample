type ExtractParams<T, K extends keyof T & string> = T[K] extends (
    ...args: infer P
) => any
    ? P
    : never
type ExtractReturn<T, K extends keyof T & string> = T[K] extends (
    ...args: any[]
) => Promise<infer R>
    ? R
    : never

export async function invokeHandler<THandler>(
    handlerRef: DotNet.DotNetObject,
    member: keyof THandler & string,
    ...args: ExtractParams<THandler, keyof THandler & string>
): Promise<ExtractReturn<THandler, keyof THandler & string>> {
    const methodName = member.charAt(0).toUpperCase() + member.slice(1)
    return handlerRef.invokeMethodAsync(methodName, ...args)
}

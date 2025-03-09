using Microsoft.JSInterop;
using Reinforced.Typings.Attributes;

namespace BlazorTsInteropExample.Adapters.CSharp;

[TsInterface]
public class BrowserConsoleAdapter(IJSRuntime js) : IAsyncDisposable
{
    IJSObjectReference? module;

    public async Task LogAsync(string message, [TsIgnore] CancellationToken cancellationToken = default)
    {
        module ??= await ImportModule(cancellationToken);
        await module.InvokeVoidAsync("default.logAsync", cancellationToken, [message]);
    }

    [TsIgnore]
    async Task<IJSObjectReference> ImportModule(CancellationToken cancellationToken)
    {
        return await js.InvokeAsync<IJSObjectReference>("import", cancellationToken, "./js/dist/browserConsoleAdapter.js");
    }

    [TsIgnore]
    ValueTask IAsyncDisposable.DisposeAsync()
    {
        if (module is { })
        {
            try
            {
                return module.DisposeAsync();
            }
            catch (ObjectDisposedException) { }
        }

        return ValueTask.CompletedTask;
    }
}

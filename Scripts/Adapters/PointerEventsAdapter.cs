using Microsoft.JSInterop;
using Reinforced.Typings.Attributes;

namespace BlazorTsInteropExample.Scripts.Adapters;

[TsInterface]
public class PointerEventsAdapter(IJSRuntime js) : IAsyncDisposable
{
    IJSObjectReference? module;

    public async Task AddForHandlerAsync<THandler>(DotNetObjectReference<THandler> handlerReference, [TsIgnore] CancellationToken cancellationToken)
        where THandler : class, IPointerEventsAdapterHandler
    {
        module ??= await ImportModule(cancellationToken);
        await module.InvokeVoidAsync("default.addForHandlerAsync", cancellationToken, [handlerReference]);
    }

    [TsIgnore]
    async Task<IJSObjectReference> ImportModule(CancellationToken cancellationToken)
    {
        return await js.InvokeAsync<IJSObjectReference>("import", cancellationToken, "./js/dist/pointerEventsAdapter.js");
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

using Reinforced.Typings.Attributes;

namespace BlazorTsInteropExample.Adapters.CSharp;

[TsInterface]
public interface IPointerEventsAdapterHandler
{
    Task HandleClickAtAsync(int x, int y);
}

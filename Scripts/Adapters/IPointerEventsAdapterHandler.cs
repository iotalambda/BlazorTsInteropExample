using Reinforced.Typings.Attributes;

namespace BlazorTsInteropExample.Scripts.Adapters;

[TsInterface]
public interface IPointerEventsAdapterHandler
{
    Task HandleClickAtAsync(int x, int y);
}

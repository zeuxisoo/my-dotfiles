local wezterm = require('wezterm')
local system = require('utils.system')

local platform = system:platform()

local GpuAdapter = {}
GpuAdapter.__index = GpuAdapter

GpuAdapter.AVAILABLE_BACKENDS = {
    windows = { 'Dx12', 'Vulkan', 'Gl' },
    linux = { 'Vulkan', 'Gl' },
    mac = { 'Metal' },
}

GpuAdapter.ENUMERATED_GPUS = wezterm.gui.enumerate_gpus()

function GpuAdapter:new()
    local initial = {
        __backends = self.AVAILABLE_BACKENDS[platform.os],
        __preferred_backend = self.AVAILABLE_BACKENDS[platform.os][1],
        DiscreteGpu = nil,
        IntegratedGpu = nil,
        Cpu = nil,
        Other = nil,
    }

    for _, adapter in ipairs(self.ENUMERATED_GPUS) do
        if not initial[adapter.device_type] then
            initial[adapter.device_type] = {}
        end

        initial[adapter.device_type][adapter.backend] = adapter
    end

    local gpu_adapters = setmetatable(initial, self)

    return gpu_adapters
end

function GpuAdapter:pick_best()
    local adapters_options = self.DiscreteGpu
    local preferred_backend = self.__preferred_backend

    if not adapters_options then
        adapters_options = self.IntegratedGpu
    end

    if not adapters_options then
        adapters_options = self.Other
        preferred_backend = 'Gl'
    end

    if not adapters_options then
        adapters_options = self.Cpu
    end

    if not adapters_options then
        wezterm.log_error('[GPU.Adapter] No GPU adapters found. Using Default Adapter.')
        return nil
    end

    local adapter_choice = adapters_options[preferred_backend]

    if not adapter_choice then
        wezterm.log_error('[GPU.Adapter] Preferred backend not available. Using Default Adapter.')
        return nil
    end

    return adapter_choice
end

return GpuAdapter:new()

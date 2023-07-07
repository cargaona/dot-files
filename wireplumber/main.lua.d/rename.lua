local sinks = {}
sinks["HDMI-1"] = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_3__sink"
sinks["HDMI-2"] = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_4__sink"
sinks["HDMI-3"] = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_5__sink"
sinks["X13"] = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink"

for sinkAlias,sinkName in pairs(sinks) do
  table.insert(alsa_monitor.rules, {
  matches = {
    {
      { "node.name", "equals", sinkName },
    },
  },
  apply_properties = {
    ["device.nick"] = sinkAlias ,
    ["device.product.name"] = sinkAlias,
    ["node.description"] = sinkAlias,
    ["device.description"] = sinkAlias ,
  },
})
end

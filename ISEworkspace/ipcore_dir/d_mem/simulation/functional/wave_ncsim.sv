

 
 
 




window new WaveWindow  -name  "Waves for BMG Example Design"
waveform  using  "Waves for BMG Example Design"

      waveform add -signals /d_mem_tb/status
      waveform add -signals /d_mem_tb/d_mem_synth_inst/bmg_port/CLKA
      waveform add -signals /d_mem_tb/d_mem_synth_inst/bmg_port/ADDRA
      waveform add -signals /d_mem_tb/d_mem_synth_inst/bmg_port/DINA
      waveform add -signals /d_mem_tb/d_mem_synth_inst/bmg_port/WEA
      waveform add -signals /d_mem_tb/d_mem_synth_inst/bmg_port/DOUTA

console submit -using simulator -wait no "run"

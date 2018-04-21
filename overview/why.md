# Why was Gemini created?


#### Background

Hardware description languages (HDLs) have existed since the 1960s as powerful tools to precisely represent the design of electrical components. As very-large-scale-integration (VLSI) became more popular for design, the first modern HDL, Verilog, was introduced between 1983 and 1984. At around the same time, the Department of Defense began developing a new standard named VHDL.

#### The Problem

Since their inception, these two HDLs and variant descendent languages have been among the most widely-used in industry for the verification, synthesis, and simulation of circuits. While successive iterations have introduced more powerful features, such as datatypes and strong type systems, they have not been able to keep up with the ways in which software programming languages have evolved. This limits their ability to concisely and efficiently express the designs they are intended to represent.

#### Enter Gemini...

The design and implementation of Gemini was motivated by the need to provide higher-level abstractions to hardware description languages in order to improve expressivity and modularity. This allows programmers to do more with less code and improves their efficiency and throughput.
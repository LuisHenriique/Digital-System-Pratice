# Tarefas

1. **Parte 1: Implementação de um Latch RS com Clock**
   - Criação de um circuito de trava RS com clock (gated RS latch) em VHDL, utilizando tabelas de consulta (LUTs) de 4 entradas em um FPGA. O objetivo é demonstrar como criar elementos de armazenamento sem utilizar flip-flops dedicados.

2. **Parte 2: Implementação de um Latch D com Clock**
   - Implementação de um latch D com clock (gated D latch) utilizando portas NAND. Esta etapa expande a funcionalidade para incluir um latch D, proporcionando um entendimento maior dos circuitos de armazenamento.

3. **Parte 3: Implementação de um Flip-Flop Master-Slave**
   - Implementação de um flip-flop master-slave de onda de subida (rising edge) em VHDL. Esta tarefa foca na criação de flip-flops que utilizam uma configuração master-slave para capturar e armazenar dados na borda de subida do clock.

4. **Parte 4: Implementação de um Circuito Combinado**
   - Criação de um circuito que combina um latch gated D com dois flip-flops master-slave, um de onda de subida (rising edge) e outro de onda de descida (falling edge). Este circuito finaliza a tarefa ao integrar diferentes tipos de elementos de armazenamento em um único design.



## Resumo da Tarefa  1

Esta tarefa envolve a criação e simulação de um circuito de trava (latch) RS com clock usando FPGA, especificamente utilizando o software Quartus da Intel. O objetivo é demonstrar como elementos de armazenamento podem ser criados em um FPGA sem utilizar flip-flops dedicados.

## Parte I: Descrição do Latch RS com Clock

Na primeira parte, é apresentado um circuito de trava RS com clock (gated RS latch), como mostrado na Figura 1. O circuito é descrito em VHDL usando expressões lógicas, conforme o código fornecido na Figura 2. Esse código utiliza portas lógicas para implementar o latch RS em uma FPGA que possui tabelas de consulta (LUTs) de 4 entradas.

### Implementação com LUTs

Embora o latch possa ser implementado corretamente em uma única LUT de 4 entradas, isso não permite a observação dos sinais internos (`R_g` e `S_g`). Para resolver isso, é utilizada uma diretiva do compilador Quartus chamada `KEEP`, que garante que cada sinal interno seja preservado e implementado em elementos lógicos separados. O resultado final é um circuito com quatro LUTs de 4 entradas, como mostrado na Figura 3b.

## Resumo da tarefa 2

Nesta tarefa, a partir da análise de um Latch D fornecido, foi solicitado que fosse implementado no Quartus/VHDL, executado na placa FPGA e analisado sua simulação no Modelsim.

### Parte I: Análise do Latch D fornecido

O latch D fornecido é implementado apenas com portas NAND e possui comportamento semelhante ao Latch da tarefa 1. Seu funcionamento é baseado no controle do clock Clk. Quando o clk está em nível lógico alto (1), a saída recebe quaisquer variações da entrada D, ou seja, enquanto o clk estiver alto, se o D for para 1, Q recebe 1; se D for para 0, Q recebe 0. Em contrapartida, quando o clk está em nível lógico baixo (0), as mudanças na entrada D não intereferem na saída Q.

### Parte II: Implementação no Quartus/VHDL

A implementação foi realizada de duas formas. 
A primeira resume-se em desenvolver um código VHDL com base no fornecido para o Latch da tarefa 1, ou seja, foram feitas modificações na lógica de implementação do primeiro código para que o funcionamento fosse transformado para o latch D.
Já a segunda, foi feita através da implementação em circuito esquemático e, então, convertido em bloco de VHDL por meio das ferramentas do Quartus.

### Parte III: Execução na placa FPGA

A placa utilizada foi a placa V. Dessa forma, foram construídos as correspondências na seção 'Assignments'para as entradas e saídas verificadas no latch D. A execução possibilitou uma análise mais prática do funcionamento do latch D.

### Parte IV: Simulação

O diagrama de tempo da simulação foi construído por meio do Modelsim. Para isso, salvou-se inicialmente o código VHDL desenvolvido no Quartus e, então, criou-se um projeto no Modelsim, cujo elemento principal era o arquivo em formato VHDL do latch D. Após a compilação, simulou-se e, manualmente, através de mudanças no 'force' dos inputs D e Clk, verificou-se as correspondentes saídas de Q. Essas correspondências podem ser analisadas no diagrama de tempo. 

## Resumo da Tarefa 3: Implementação de um Flip-Flop Master-Slave

Nesta parte do projeto, implementamos um flip-flop master-slave tipo D, utilizando os latches (gated D ) desenvolvidos na Parte II. O flip-flop master-slave é um componente essencial em circuitos sequenciais, utilizado para armazenar e transferir dados de forma sincronizada com o clock.

### Funcionamento do Flip-Flop Master-Slave:

- **Estrutura do Circuito:**
  - O flip-flop master-slave é composto por dois latches D conectados em série. O primeiro latch funciona como o "Master", enquanto o segundo atua como o "Slave".
  - O latch "Master" captura o valor de entrada D quando o clock está em nível baixo (0). Durante esse período, o latch "Slave" permanece bloqueado e não altera seu estado.
  - Quando o clock sobe para nível alto (1), o latch "Master" é bloqueado, e o valor capturado é transferido para o latch "Slave", que então atualiza sua saída Q.

- **Comportamento Sincronizado:**
  - A transferência de dados ocorre apenas na transição do clock de baixo para alto, garantindo que as mudanças nos dados sejam estáveis e sincronizadas, evitando alterações indesejadas causadas por flutuações ou ruídos no sinal.

- **Saída Q:**
  - A saída Q reflete o valor armazenado no latch "Slave", representando o estado do flip-flop após a borda de subida do clock. Este valor é mantido constante até a próxima borda de subida, independentemente de mudanças na entrada D durante o ciclo do clock.

A construção deste flip-flop master-slave utilizando os latches D com clock da Parte II permite a captura e o armazenamento de dados de maneira precisa e previsível, sendo ideal para aplicações que requerem sincronização e integridade dos dados.


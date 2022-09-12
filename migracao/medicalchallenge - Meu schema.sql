-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 12-Set-2022 às 03:34
-- Versão do servidor: 10.4.24-MariaDB
-- versão do PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `medicalchallenge`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `agendamentos`
--

CREATE TABLE `agendamentos` (
  `id` int(11) NOT NULL,
  `id_paciente` int(11) DEFAULT NULL,
  `id_profissional` int(11) NOT NULL,
  `dh_inicio` datetime NOT NULL,
  `dh_fim` datetime NOT NULL,
  `id_convenio` int(11) DEFAULT NULL,
  `id_procedimento` int(11) DEFAULT NULL,
  `observacoes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `agendamentos`
--

INSERT INTO `agendamentos` (`id`, `id_paciente`, `id_profissional`, `dh_inicio`, `dh_fim`, `id_convenio`, `id_procedimento`, `observacoes`) VALUES
(1, 1, 85217, '2021-05-12 11:15:00', '2021-05-12 11:30:00', 1, 1, 'Primeira consulta do paciente.'),
(2, 1, 85217, '2021-05-14 08:00:00', '2021-05-14 08:30:00', 1, 2, 'Retorno do paciente.'),
(3, 3, 85218, '2021-06-01 14:30:00', '2021-06-01 14:45:00', 4, 3, 'Acompanhamento de rotina.');

-- --------------------------------------------------------

--
-- Estrutura da tabela `convenios`
--

CREATE TABLE `convenios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `convenios`
--

INSERT INTO `convenios` (`id`, `nome`, `descricao`) VALUES
(1, 'Particular', 'Convênio Particular (Padrão)'),
(2, 'DevMed', 'Convênio da Empresa Dev'),
(3, 'Migracao', 'Migracao'),
(4, 'MigraMed', 'Convênio dos Funcionário de Migração da Empresa Dev'),
(5, 'Hospital', 'Hospital');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pacientes`
--

CREATE TABLE `pacientes` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `sexo` enum('Masculino','Feminino') NOT NULL,
  `nascimento` date NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `rg` varchar(20) NOT NULL,
  `id_convenio` int(11) NOT NULL,
  `cod_referencia` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `pacientes`
--

INSERT INTO `pacientes` (`id`, `nome`, `sexo`, `nascimento`, `cpf`, `rg`, `id_convenio`, `cod_referencia`) VALUES
(1, 'Paciente de Testes', 'Masculino', '1989-05-12', '000.000.000-00', '00000-0', 1, ''),
(2, 'Fulano de Tal', 'Masculino', '1974-06-19', '111.111.111-22', '11111-2', 1, ''),
(3, 'Ciclano de Tal', 'Masculino', '2001-12-25', '222.222.222-33', '22222-3', 4, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `procedimentos`
--

CREATE TABLE `procedimentos` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `procedimentos`
--

INSERT INTO `procedimentos` (`id`, `nome`, `descricao`) VALUES
(1, 'Consulta', 'Procedimento Padrão da Clínica'),
(2, 'Retorno', 'Pacientes em Caráter de Retorno'),
(3, 'Acompanhamento', 'Consulta de Acompanhamento');

-- --------------------------------------------------------

--
-- Estrutura da tabela `profissionais`
--

CREATE TABLE `profissionais` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `crm` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `profissionais`
--

INSERT INTO `profissionais` (`id`, `nome`, `crm`) VALUES
(85217, 'Dr. Lucas KNE', NULL),
(85218, 'Dr. Analista Pietro', NULL),
(85219, 'Suporte MedicalChallenge', NULL);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `agendamento_id_convenio_idx` (`id_convenio`),
  ADD KEY `agendamento_id_procedimento_idx` (`id_procedimento`),
  ADD KEY `agendamento_id_profissional_idx` (`id_profissional`),
  ADD KEY `agendamento_id_paciente_idx` (`id_paciente`);

--
-- Índices para tabela `convenios`
--
ALTER TABLE `convenios`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `paciente_id_convenio_idx` (`id_convenio`);

--
-- Índices para tabela `procedimentos`
--
ALTER TABLE `procedimentos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `profissionais`
--
ALTER TABLE `profissionais`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=176;

--
-- AUTO_INCREMENT de tabela `convenios`
--
ALTER TABLE `convenios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `procedimentos`
--
ALTER TABLE `procedimentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `profissionais`
--
ALTER TABLE `profissionais`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85220;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `agendamentos`
--
ALTER TABLE `agendamentos`
  ADD CONSTRAINT `agendamento_id_convenio` FOREIGN KEY (`id_convenio`) REFERENCES `convenios` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `agendamento_id_paciente` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `agendamento_id_procedimento` FOREIGN KEY (`id_procedimento`) REFERENCES `procedimentos` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `agendamento_id_profissional` FOREIGN KEY (`id_profissional`) REFERENCES `profissionais` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

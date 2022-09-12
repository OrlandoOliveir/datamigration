<?php 

$hostname="localhost";
$bdname="medicalchallenge";
$user="root";
$password="";

$connection = new mysqli($hostname, $user, $password, $bdname,) or die ("Não foi possível encontrar o servidor");
mysqli_set_charset($connection,"utf8");

$filepath_agendamentos = 'csv/agendamentos.csv';  //Aqui deve ser informado o caminho do arquivo! Poderia ser uma função dinamica
   
    
    //abertura e criação do cabeçalho do arquivo para termos acesso aos dados. Caso o arquivo exista, o código será executado, se não, ele irá avisar que o path não foi encontrado.     
    
    $filepath_agendamentos = 'csv/agendamentos.csv';
    if(file_exists($filepath_agendamentos)){
    $handle = fopen($filepath_agendamentos, "r");
    $header = fgetcsv($handle,0,";");
    echo "<pre>";
    
    //Enquanto a variavel data estiver recebendo dados, significa que o script precisa percorrer mais uma linha do documento
   
    while($data = fgetcsv($handle,0,";")){

    //Associando o conteúdo do array ao seu cabeçalho, para mapearmos os campos
        
        $row = array_combine($header,$data);

    // Padronização dos dados a serem inseridos. O ideal aqui seria ter funções para automatizar o processo.
        
        $row["dh_inicio"] = explode(" ", $row["dh_inicio"]);
        $row["dh_inicio"] = implode("-", $row["dh_inicio"]);                
        $row["dh_final"] = explode("-", $row["dh_final"]);                
        $row["dh_final"] = implode("-", $row["dh_final"]);                

    //Após a padronização dos dados nos arrays, eu posso separa-los para usar na nossa query de inserção ao banco!

        $id = $row['cod_agendamento'];
        $cod_paciente= $row['id_paciente'];
        $id_profissional = $row['cod_medico'];
        $dh_inicio = $row['dh_inicio'];
        $dh_final = $row['dh_final'];
        $cod_convenio = $row['cod_convenio'];
        $cod_procedimento = $row['cd_procedimento'];
        $desc_agendamento = $row['desc_agendamento'];


        $query ="INSERT INTO agendamentos (id,id_paciente,id_profissional,dh_inicio,dh_fim,id_convenio,id_procedimento,observacoes) VALUES ('$id','$cod_paciente','$id_profissional','$dh_inicio','$dh_final','$cod_convenio','$cod_procedimento','$desc_agendamento');";
        
        
        $query=$connection->prepare($query);
    
    //Mensagem para nos avisar que os dados foram inseridos, caso contrário, retorna o número e a descrição do erro.

        if($query->execute()){

            echo "Registros criados no banco!'- $id agendamento -' 
        ";

        }else{

            echo mysqli_errno($connection,$query);
            echo mysqli_error($connection,$query);
        }
                      
       
    }
 }

    fclose($handle);
    
    die;

    //fechando a conexão com o arquivo para evitar problemas de processamento
?>
<?php 

$hostname="localhost";
$bdname="medicalchallenge";
$user="root";
$password="";

$connection = new mysqli($hostname, $user, $password, $bdname,) or die ("Não foi possível encontrar o servidor");
mysqli_set_charset($connection,"utf8");

$filepath_agendamentos = 'csv/agendamentos.csv'; //Aqui deve ser informado o caminho do arquivo! Poderia ser uma função dinamica
      
   
    //abertura e criação do cabeçalho do arquivo para termos acesso aos dados. Caso o arquivo exista, o código será executado, se não, ele irá avisar que o path não foi encontrado.
       
    $filepath_pacientes = 'csv/pacientes.csv';
    if(file_exists($filepath_pacientes)){
    $handle = fopen($filepath_pacientes, "r");
    $header = fgetcsv($handle,0,";");
    echo "<pre>";
    
    //Enquanto a variavel data estiver recebendo dados, significa que o script precisa percorrer mais uma linha do documento
   
    while($data = fgetcsv($handle,0,";")){

    //Associando o conteúdo do array ao seu cabeçalho, para mapearmos os campos
        
        $row = array_combine($header,$data);

    // Padronização dos dados a serem inseridos. O ideal aqui seria criar funções.
        
        $row["nasc"] = explode("/", $row["nasc"]);
        $row["nasc"] = array_reverse($row["nasc"]);
        $row["nasc"] = implode("-", $row["nasc"]);
        $row["nome"] = array_filter((explode(" ", $row["nome"])));  
        $row["nome"] = implode(" ", $row["nome"]);
        

    //Após a padronização dos dados nos arrays, eu posso separa-los para usar na nossa query de inserção ao banco!
       
        $id = $row["id"];
        $nome = $row["nome"];
        $sexo = $row["sexo"];
        $nasc = $row["nasc"];
        $cpf = $row["cpf"];
        $rg = $row["rg"];
        $id_convenio = $row["id_conv"];
        $cod_referencia = $row["cod_referencia"];

    //Após nomear e separar os dados eu faço uma query para envia-los ao banco! Nesta etapa aqui os dados já estão padronizados. 

        $query ="INSERT INTO pacientes (id,nome,sexo,nascimento,cpf,rg,id_convenio,cod_referencia) VALUES ('$id','$nome','$sexo','$nasc','$cpf','$rg','$id_convenio','$cod_referencia');";
        
            

        $query=$connection->prepare($query);
    
    //Mensagem para nos avisar que os dados foram inseridos, caso contrário, retorna o número e a descrição do erro.

        if($query->execute()){

            echo "Registros criados no banco!'- $id paciente -' 
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
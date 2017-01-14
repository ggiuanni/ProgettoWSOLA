# ProgettoWSOLA
Progetto per il corso di Elaborazione dell'audio digitale, a.a. 2016/2017, Politecnico di Torino.

Studente: Giovanni Cassone - **s231404**
## Installazione
Il file contenente il codice è *Progetto_wsola.m*.

Una volta scaricato, sarà possibile importarlo su MATLAB tramite i seguenti passaggi:
- Selezionare la cartella (folder) nel quale è contenuto il file *Progetto_wsola.m*;
- Fare doppio click sul file.

Il file contiene al suo interno:
- Il codice di caricamento di un file audio, settaggio dei parametri L, S, Delta e TSR, e la chiamata alla funzione wsola_processing;
- Il codice della funzione wsola_processing che prende in ingresso il file audio importato e i parametri settati precendentemente.

Per effettuare il Run sarà necessaria la presenza del file audio da sottoporre al processo all'interno della stessa cartella del file
importato.

## Configurazione
Dalle righe `7` a `9` è possibile settare i valori L, S, Delta e TSR:
```
L = round(0.03*Fs); % 30ms

S = round(0.5*L); % 50% overlap

delta = 40;

TSR = 0.5;
```
Questi parametri di default prevedono un settaggio per un audio vocale (tarato su speech.wav).

Dalla riga `12` alla `14` sono invece presenti i parametri nel caso in cui si voglia processare una traccia musicale
(tarati su furelise.wav).

Indifferentemente dai valori dei parametri precedenti, il TSR può essere compreso tra i valori 0.50 e 2.00.

## Esecuzione del codice
Alla riga di codice `1` è possibile selezionare il file audio da processare:

`filename = 'speech.wav';`

Una volta selezionato il file audio e settati i parametri basterà avviare la funzione `Run` di MATLAB per eseguire il codice.

Al termine dell'escecuzione del codice il segnale audio processato verrà salvato su disco come nuovo file (nome file di origine_TSR.wav)
in una sottocartella (output_audio) che, se non già presente, verrà creata automaticamente.

Infine è possibile impedire o meno l'esecuzione del file audio processato commentando o decommentando la riga `20`
(commentato di default):
```
%sound(y,Fs);
```

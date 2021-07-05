# iOS Reddit Top50 ![CI](https://github.com/lluizteixeira/ios-reddit-top50/workflows/main.yml/badge.svg)

Repository for App IOS Reddit Top 50

App shows a list for the Top 50 posts in [Reddit] - www.reddit.com/top

# Requirements

- iOS 14.0+
- Xcode 12+
- Swift 5.3

# Installation

No requirements for running the app

# Architecture 

The app uses MVVM https://www.objc.io/issues/13-architecture/mvvm/. Logic is typically held in ViewModel that access a Service for external APIs and with that ViewModel updates the Views.

    - View: Esta camada é a interface do usuário. No caso do ela inclui qualquer código específico da plataforma para conduzir a interface do usuário da aplicação.

    - Model: A camada de modelo é a lógica de dados que impulsiona a aplicação e quaisquer objetos de negócios, contém entidades da aplicação, fazendo com que backend e frontend sejam um único ecossistema;

    - ViewModel: Esta camada age como um conector lógico em aplicações MVVM. As camadas ViewModel coordenam as operações entre a view e as camada de dados (repository) acessando Models,  Services (acesso a API de dados / Base de dados local - backend) e classes de regras de negócio. Uma camada ViewModel irá conter propriedades que a View vai obter ou definir, e funções para cada operação que pode ser feita pelo usuário em cada view. A camada ViewModel evocará operações sobre a camada Model, se necessário, contendo ou interligando muitas vezes a lógica de negócio utilizada pelas funcionalidades do aplicativo.

    - Services: Camada separada da lógica e views para a requisição, mapeamento e manipulação de dados da API.
    
## Project Structure

    ├─ Enums
    ├─ Network
        ├─ Services
    ├─ Models
    ├─ ViewModels
    ├─ Views
        ├─ ViewControllers
        ├─ TableViewCells
        ├─ Storyboards
    ├─ Extensions
    ├─ Resources
    ├─ Application  


## more
The app has been implemented using:
    
    - Use Storyboards
    - UISpliViewController for feed and post detail flow
    - UITableView for feed
    - URLSession + Combine for API calls
    - Unit tests 
    - Support all Devices screen (iPhone/iPad)

## Resources

    - [Reddit API](http://www.reddit.com/dev/api)

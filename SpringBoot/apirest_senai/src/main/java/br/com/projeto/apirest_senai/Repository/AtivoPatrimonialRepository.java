package br.com.projeto.apirest_senai.Repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import br.com.projeto.apirest_senai.Model.AtivoPatrimonialModel;

@Repository
public interface AtivoPatrimonialRepository extends CrudRepository<AtivoPatrimonialModel, Long> {
}

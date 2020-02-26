package com.polls.repository;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.polls.model.MasterUser;

@Repository
public interface UserRepository extends JpaRepository<MasterUser, Long>{
	Optional<MasterUser> findByEmail(String email);
	
	Optional<MasterUser> findByUsernameOrEmail(String username, String email);
	
	List<MasterUser> findByIdIn(List<Long> userIds);
	
	Optional<MasterUser> findByUsername(String username);
	
	Boolean existsByUsername(String username);
	
	Boolean existsByEmail(String email);
}

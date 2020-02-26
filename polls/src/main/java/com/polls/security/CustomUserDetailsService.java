package com.polls.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.polls.exception.ResourceNotFoundException;
import com.polls.model.MasterUser;
import com.polls.repository.UserRepository;

/**
 * @author Aris
 *
 */

@Service
public class CustomUserDetailsService implements UserDetailsService{

	@Autowired
	UserRepository userRepository;
	
	@Override
	@Transactional
	public UserDetails loadUserByUsername(String usernameOrEmail) throws UsernameNotFoundException {
		//Let people login with either username or email
		MasterUser masterUser = userRepository.findByUsernameOrEmail(usernameOrEmail, usernameOrEmail)
				.orElseThrow(() ->
				new UsernameNotFoundException("User not found with username or email : " + usernameOrEmail));
		return UserPrincipal.create(masterUser);
	}
	
	@Transactional
	public UserDetails loadUserById(Long id) {
		MasterUser masterUser = userRepository.findById(id)
				.orElseThrow(() -> new ResourceNotFoundException("User", "id", id));
		return UserPrincipal.create(masterUser);
	}
}

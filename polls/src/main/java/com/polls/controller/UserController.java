package com.polls.controller;

import java.util.Collection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.polls.exception.ResourceNotFoundException;
import com.polls.model.MasterUser;
import com.polls.payload.UserIdentityAvailability;
import com.polls.payload.UserProfile;
import com.polls.payload.UserSummary;
import com.polls.payload.PagedResponse;
import com.polls.payload.PollResponse;
import com.polls.repository.PollRepository;
import com.polls.repository.UserRepository;
import com.polls.repository.VoteRepository;
import com.polls.security.CurrentUser;
import com.polls.security.UserPrincipal;
import com.polls.service.PollService;
import com.polls.util.AppConstants;

@RestController
@RequestMapping("/api")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PollRepository pollRepository;

    @Autowired
    private VoteRepository voteRepository;

    @Autowired
    private PollService pollService;

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @GetMapping("/user/me")
    @PreAuthorize("hasAnyRole('USER','ADMIN')")
    public UserSummary getCurrentUser(@CurrentUser UserPrincipal currentUser) {
        UserSummary userSummary = new UserSummary(currentUser.getId(), currentUser.getUsername(), currentUser.getName());
        Collection<GrantedAuthority> grantedAuthors = (Collection<GrantedAuthority>) currentUser.getAuthorities();
        for (GrantedAuthority grantedAuthority : grantedAuthors) {
        	if (("ROLE_ADMIN").equalsIgnoreCase(grantedAuthority.getAuthority())) {
        		userSummary.setRole("ROLE_ADMIN");
			} else if (("ROLE_USER").equalsIgnoreCase(grantedAuthority.getAuthority())) {
				userSummary.setRole("ROLE_USER");
			}
        	
		}
        
        boolean admin = false;
        boolean user = false;
        if (grantedAuthors.size() > 1) {
			for (GrantedAuthority grantedAuthority : grantedAuthors) {
				if (("ROLE_ADMIN").equalsIgnoreCase(grantedAuthority.getAuthority())) {
					admin = true;
				}
				if (("ROLE_USER").equalsIgnoreCase(grantedAuthority.getAuthority())) {
					user = true;
				}
			}
			if (admin && user) {
				userSummary.setRole("ROLE_ADMIN");
			}
		}
        
        return userSummary;
    }

    @GetMapping("/user/checkUsernameAvailability")
    public UserIdentityAvailability checkUsernameAvailability(@RequestParam(value = "username") String username) {
        Boolean isAvailable = !userRepository.existsByUsername(username);
        return new UserIdentityAvailability(isAvailable);
    }

    @GetMapping("/user/checkEmailAvailability")
    public UserIdentityAvailability checkEmailAvailability(@RequestParam(value = "email") String email) {
        Boolean isAvailable = !userRepository.existsByEmail(email);
        return new UserIdentityAvailability(isAvailable);
    }

    @GetMapping("/users/{username}")
    public UserProfile getUserProfile(@PathVariable(value = "username") String username) {
        MasterUser user = userRepository.findByUsername(username)
                .orElseThrow(() -> new ResourceNotFoundException("User", "username", username));

        long pollCount = pollRepository.countByCreatedBy(user.getId());
        long voteCount = voteRepository.countByUserId(user.getId());

        UserProfile userProfile = new UserProfile(user.getId(), user.getUsername(), user.getName(), user.getCreatedAt(), pollCount, voteCount);

        return userProfile;
    }

    @GetMapping("/users/{username}/polls")
    public PagedResponse<PollResponse> getPollsCreatedBy(@PathVariable(value = "username") String username,
                                                         @CurrentUser UserPrincipal currentUser,
                                                         @RequestParam(value = "page", defaultValue = AppConstants.DEFAULT_PAGE_NUMBER) int page,
                                                         @RequestParam(value = "size", defaultValue = AppConstants.DEFAULT_PAGE_SIZE) int size) {
        return pollService.getPollsCreatedBy(username, currentUser, page, size);
    }


    @GetMapping("/users/{username}/votes")
    public PagedResponse<PollResponse> getPollsVotedBy(@PathVariable(value = "username") String username,
                                                       @CurrentUser UserPrincipal currentUser,
                                                       @RequestParam(value = "page", defaultValue = AppConstants.DEFAULT_PAGE_NUMBER) int page,
                                                       @RequestParam(value = "size", defaultValue = AppConstants.DEFAULT_PAGE_SIZE) int size) {
        return pollService.getPollsVotedBy(username, currentUser, page, size);
    }

}

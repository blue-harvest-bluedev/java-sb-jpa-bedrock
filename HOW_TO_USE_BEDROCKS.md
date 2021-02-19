# How to use bedrocks

## How to create a new project using the bedrocks

1. Create a new git project in your preferred repository management (GitHub, GitLab, BitBucket, etc).

2. Clone your newly created project.
    ```shell script
    git clone [URL FROM STEP 1]
    ```

3. Add the bedrocks you want to use as remotes.

    ```shell script
    git remote add [REMOTE 1] [BEDROCK URL 1]
    git remote add [REMOTE 2] [BEDROCK URL 2]
    # Example:
    git remote add rest_bedrock https://gitlab.com/blue-harvest/the-harvest/blueprints/bluedev/java-sb/bedrock-sb-java-rest.git
    ```

4. Verify that the new remotes have been added.

    ```shell script
    git remote -v
    ```
   
5. For each bedrock you added, fetch and merge changes from its remote. 

    The first bedrock you merge, shouldn't cause any merge conflict. 
    From the second one, some merge conflicts might occur: on the `customize.sh` and `customize.cmd` files,
    you should resolve the conflicts by including the changes from all the bedrocks

    ```shell script
    # Merging [REMOTE 1]
    git fetch [REMOTE 1]
    # The changes will be stored in a local branch called [REMOTE 1]/main
    git merge [REMOTE 1]/main
    # If there are conflicts, resolve them and merge them:
    git commit -m "Merged latest changes from [REMOTE 1] bedrock into main"
    
    # Merging [REMOTE 2]
    git fetch [REMOTE 2]
    # The changes will be stored in a local branch called [REMOTE 2]/main
    git merge [REMOTE 2]/main
    # If there are conflicts, resolve them and merge them:
    git commit -m "Merged latest changes from [REMOTE 2] bedrock into main"
    
    # Example:
    git fetch rest_bedrock
    # The changes will be stored in a local branch called rest_bedrock/main
    git merge rest_bedrock/main
    # If there are conflicts, resolve them and merge them:
    git commit -m "Merged latest changes from parent into main"
    ```
   
6. Push updates to your own remote.
    ```shell script
    git push origin main
    ```
   
7. Run the `customize.cmd` or the `customize.sh` script to finish the rest of the configuration.

   If you are using windows system run this command:

   ```shell script
   .\customize.cmd
    ```
   If you are using unix system run this command:

   ```shell script
   chmod +x customize.sh && ./customize.sh 
   ```

8. Commit and push your changes to main.

9. Periodically fetch updated from the remotes and include them in your project

## How to add bedrocks to an existing project

### The existing project is not based on any bedrock

1. Create a new local branch.
    ```shell script
    git branch feature/bedrocks
    git checkout feature/bedrocks
    ```

2. While on the new branch, delete all the files in your working directory (except .gitignore and/or IDE related files), and commit the changes
    ```shell script
    git add .
    git commit -m "Clean up working directory."
    ```

3. Follow the guide [How to create a new project using the bedrocks](#how-to-create-a-new-project-using-the-bedrocks) excluding steps 1 and 2.

4. Introduce again your source code in the new structure created by the bedrocks.

5. Periodically fetch updated from the remotes and include them in your project

### The existing project is based on any bedrock

1. Follow the guide [How to create a new project using the bedrocks](#how-to-create-a-new-project-using-the-bedrocks) excluding steps 1 and 2. 
Keep in mind that the script will ask you to provide input values already used for previous bedrocks.
It's really important to provide the same values as before.

2. Introduce again your source code in the new structure created by the bedrocks.

3. Periodically fetch updated from the remotes and include them in your project
